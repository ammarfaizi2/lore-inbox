Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWEZIcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWEZIcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWEZIcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:32:19 -0400
Received: from relay4.usu.ru ([194.226.235.39]:62155 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750706AbWEZIcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:32:18 -0400
Message-ID: <4476BD28.8040405@ums.usu.ru>
Date: Fri, 26 May 2006 14:32:40 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Jon Smirl <jonsmirl@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com> <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru> <4476A951.2070003@aitel.hist.no>
In-Reply-To: <4476A951.2070003@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.1.32; VDF: 6.34.1.144; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> "Which of the two keyboards to read, which of the three screens to use
> for messages" is not a problem.  The kernel would use whatever devices
> is associated with the primary console - any extra devices would be left 
> alone.
> The console is normally one particular keyboard (or possibly all of them),
> and /dev/fb0 in case of graphical console.  Other framebuffers are
> not the primary console.

I am not sure how this can be achievable, assuming that udev is responsible for 
loading framebuffer modules. Since it loads them in parallel, the registration 
order is essentially random. See the following Debian bugs about other subsystems:

http://bugs.debian.org/339951
http://bugs.debian.org/365226

-- 
Alexander E. Patrakov
