Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbVBDHkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVBDHkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVBDHjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:39:04 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:61621 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263116AbVBDHS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:18:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tltQ/1BrVd7yVbIhOuK/sDhV6shvnUOB1sSlU7jNhzD/Bm2+sy9pt3YqfRu+NCb8EEA1/c9Cp71wDL1tWCA96YmJUL5PHOEEXwGA79089H7eWuH5C+QBRgcvgod4V6LgyG7qqfYvX1puWwSp8FdAOHtLkSGd7xMMb9QYbjxqwhk=
Message-ID: <9e4733910502032318460f2c0c@mail.gmail.com>
Date: Fri, 4 Feb 2005 02:18:58 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: ncunningham@linuxmail.org
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Pavel Machek <pavel@ucw.cz>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1107485504.5727.35.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2005 13:51:55 +1100, Nigel Cunningham
<ncunningham@linuxmail.org> wrote:
> > User has triggered resume
> > run wakeup.S

wakeup.S runs in real mode. Why can't it just call the VBIOS at
C000:0003 to reset the hardware before setting the mode?

-- 
Jon Smirl
jonsmirl@gmail.com
