Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVCVHag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVCVHag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVCVHag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:30:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62131 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262340AbVCVH3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:29:48 -0500
Date: Tue, 22 Mar 2005 02:29:36 -0500
From: Dave Jones <davej@redhat.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kenan Esau <kenan.esau@conan.de>, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 1/4] Lifebook: dmi on x86 only
Message-ID: <20050322072936.GA9802@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Kenan Esau <kenan.esau@conan.de>, harald.hoyer@redhat.de,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Vojtech Pavlik <vojtech@suse.cz>
References: <20050217194217.GA2458@ucw.cz> <1111419068.8079.15.camel@localhost> <200503220213.46375.dtor_core@ameritech.net> <200503220214.55379.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503220214.55379.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 02:14:55AM -0500, Dmitry Torokhov wrote:
 > ===================================================================
 > 
 > Input: lifebook - DMI facility is only available on i386, do not
 >        attempt to compile on anything else.

Why would you want to build a driver for an x86 laptop on anything
but x86 ?    Ie, why not just add a dependancy in the Kconfig
so you don't have to add ifdefs to the code ?

		Dave

