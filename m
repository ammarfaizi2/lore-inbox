Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWFGMyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWFGMyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 08:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWFGMyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 08:54:44 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:3106 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750728AbWFGMyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 08:54:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HeqJRJ7KQ0YPRPC7IyJPmpG5JSrhGh8EtblKfI5DU4bW52G2MpgluhC8JQRRqDoHKh4jHjz6mqioM9E8Lphwr6twFt7bsradxNbM9GoHV3SzxW9GLsUSPc1dctBt2JJ3d738HwaaEru2ScHm/6tR1XYY+QRSXadKI4J4+VXEGX8=
Message-ID: <f69849430606070554h5cadb39cgfd5f70f6de09707c@mail.gmail.com>
Date: Wed, 7 Jun 2006 17:54:43 +0500
From: "kernel coder" <lhrkernelcoder@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: RTL explaination
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
I'm trying to understand the rtl genrated by gcc for mips processor.I
have read gcc internals by Richard Stallman but there  are still some
confusions in the rtl language.

Following is a snippet of code which i'm trying to understand.

(insn 9 6 10 (nil) (set (reg:SI 182)
        (mem/f:SI (symbol_ref:SI ("a")) [0 a+0 S4 A32])) -1 (nil)
    (nil))

In the above code following part is still unclear to me

[0 a+0 S4 A32])) -1 (nil)
    (nil))

Following is the c code for which above rtl is generated :

int a;
main()
{
a=a+1;
}


thanks,
shahzad
