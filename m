Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVLHQPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVLHQPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVLHQPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:15:12 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:33910 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932192AbVLHQPK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:15:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=O8S5rN1Z85tFfyqeWoYmOBnTqR8e9YH2iiXp9zWIEMWNWnAjfaq6JR2Ads4BmwIVei0+ATrs/TssgHb+CpfkMTYm3jbB+ozPMXlozf1TJkErm1LL8n0WdvrTL2K4/8kXiWPoWfLxmwcDejQk/84Vy3fMNlguuPupgEKbcBJnywI=
Date: Thu, 8 Dec 2005 17:14:44 +0100
From: Diego Calleja <diegocg@gmail.com>
To: dirk@steuwer.de
Cc: rdunlap@xenotime.net, wli@holomorphy.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-Id: <20051208171444.511b2567.diegocg@gmail.com>
In-Reply-To: <6798653.142371134056986823.JavaMail.servlet@kundenserver>
References: <6798653.142371134056986823.JavaMail.servlet@kundenserver>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 08 Dec 2005 16:49:46 +0100,
dirk@steuwer.de escribió:

> How about interconnecting it with the bugtracker?

bugzilla is probably the best example of why human-managed "databases"
are never 100% accurate and need lots of mainteinance 8) (take a look
at mozilla's or kernel's bugzilla...). I'm tracking manually some 
of the new devices supported in http://wiki.kernelnewbies.org/LinuxChanges
but there're so many changes under drivers/* that god knows how many
things I am missing. Expecting that people will maintain a wiki or a
buzgilla or anything similar properly is like expecting that people
will document or compile-test their patches before submitting them :P

I think that the infrastructure for building such database automatically
is already there: In the same way MODULE_DEVICE_TABLE is used by hotplug
& friends to load the right module you can use MODULE_DEVICE_TABLE to
build a database of the devices supported by a kernel compiled with
"make allmodconfig", parse it and put it in a web page.
