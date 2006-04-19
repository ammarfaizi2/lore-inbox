Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWDSXLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWDSXLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWDSXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:11:17 -0400
Received: from webmail.terra.es ([213.4.149.12]:59242 "EHLO
	csmtpout2.frontal.correo") by vger.kernel.org with ESMTP
	id S1750893AbWDSXLR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:11:17 -0400
Date: Thu, 20 Apr 2006 01:00:45 +0200 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: Andi Kleen <ak@suse.de>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-Id: <20060420011037.6b2c5891.grundig@teleline.es>
In-Reply-To: <p73mzeh2o38.fsf@bragg.suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	<1145470463.3085.86.camel@laptopd505.fenrus.org>
	<p73mzeh2o38.fsf@bragg.suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El 20 Apr 2006 00:32:43 +0200,
Andi Kleen <ak@suse.de> escribió:

> Some people claim it will be used in the future in a particular application
> that most people I know don't want to have anything to do with,
> but right now that application uses an own file system that is also unlikely
> to work with selinux or anything so it won't change anything for that.
> 
> I'm not aware of any other proposed application.

However such application may exist in the future (which is why the feature
was implemented, i guess). If AppArmor becomes widespread in the future
(well suse has it anyway so it's already quite widespread) it won't be easy
to  create succesful apps which play with namespaces, not to speak that it
won't be possible to "securize" such apps. From my user POV it seems
really weird that a feature forbids you from using another unrelated feature.

