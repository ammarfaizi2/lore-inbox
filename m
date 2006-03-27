Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWC0HDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWC0HDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 02:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWC0HDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 02:03:53 -0500
Received: from wproxy.gmail.com ([64.233.184.229]:36216 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750759AbWC0HDw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 02:03:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l3tech2snlC3KSf7ayNNj5GlZQ4mDLHwUgQRzE/KxyGaBgJKclus6vCsBfyesQPuKORbfKpveGE+cAWgN7Ywf3o8ls4FXaLy4Q37QQBD8Iysl1aTztlFCLjLh1liHE98kAZVs42wN7N2Y03ADtpvr0jtZaIRKpGOFg9fN+eYWV0=
Message-ID: <489ecd0c0603262303i7f4044b8id8aa6ab01bc1d2a8@mail.gmail.com>
Date: Mon, 27 Mar 2006 15:03:48 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: mingo@redhat.com, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Question about generic IRQ framework
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  I am porting Blackfin's irq code to the generic IRQ framework. Now I
have one question: the show_interrupts() function is generic and
platform-independent, why not put it in the generic code in
kernel/irq/ ? So architecture developers don't have to do the
copy/paste job.

--
Best regards,
Luke Yang
luke.adi@gmail.com
