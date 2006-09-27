Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWI0AWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWI0AWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 20:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWI0AWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 20:22:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:32740 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750785AbWI0AWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 20:22:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ab9oSUaBrT4loieJD+Yjwt86/UYgTqQqo4FcDo/3Mz/61ROGyMjjR4lXdANhNDxiK99E5ZRlU4dhNOCUZQdmEHp5510QiJ40MmT5UMD8uSKPjnRuNxymFerZdLc4ETx1BnHJ019KaQwzyEkCDuKiNjm3s//aj3dawQ5ar4bVkuw=
Message-ID: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
Date: Wed, 27 Sep 2006 02:22:18 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Tiny error in printk output for clocksource : a3:<6>Time: acpi_pm clocksource has been installed.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this in dmesg with 2.6.18-git6 :
      a3:<6>Time: acpi_pm clocksource has been installed.

Looks like some printk() somewhere is not adding \n correctly after
outputting a message priority or a message priority too much is
used... I've not investigated where this happens, but just wanted to
report it.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
