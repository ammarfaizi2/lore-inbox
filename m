Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132465AbRCZQdN>; Mon, 26 Mar 2001 11:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132469AbRCZQdE>; Mon, 26 Mar 2001 11:33:04 -0500
Received: from [204.244.205.25] ([204.244.205.25]:3953 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S132465AbRCZQcs>;
	Mon, 26 Mar 2001 11:32:48 -0500
Subject: Re: [PATCH] OOM handling
From: Michael Peddemors <michael@linuxmagic.com>
To: matthew@mattshouse.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45961.192.168.1.5.985572801.squirrel@matthew.mattshouse.com>
In-Reply-To: <3ABDF8A6.7580BD7D@evision-ventures.com> 
	<45961.192.168.1.5.985572801.squirrel@matthew.mattshouse.com>
Content-Type: text/plain
X-Mailer: Evolution (0.9 - Preview Release)
Date: 26 Mar 2001 08:11:05 -0800
Mime-Version: 1.0
Message-Id: <20010326163254Z132465-407+3478@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uh... and aside from init, mission critical stuff... crond should never
get killed, it runs mission critical cleanup tasks..
If crond dies, might as well make the machine die in a lot of cases.. I
hate to miss my nightly database exports...

Getting to look more and more like we need some way to configure certain
tasks at the admin level to never die..


-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
WizardInternet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada

