Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVCVHfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVCVHfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVCVHer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:34:47 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:11959 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262304AbVCVHdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:33:10 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 1/4] Lifebook: dmi on x86 only
Date: Tue, 22 Mar 2005 02:33:05 -0500
User-Agent: KMail/1.7.2
Cc: Kenan Esau <kenan.esau@conan.de>, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20050217194217.GA2458@ucw.cz> <200503220214.55379.dtor_core@ameritech.net> <20050322072936.GA9802@redhat.com>
In-Reply-To: <20050322072936.GA9802@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220233.07184.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2005 02:29, Dave Jones wrote:
> On Tue, Mar 22, 2005 at 02:14:55AM -0500, Dmitry Torokhov wrote:
>  > ===================================================================
>  > 
>  > Input: lifebook - DMI facility is only available on i386, do not
>  >        attempt to compile on anything else.
> 
> Why would you want to build a driver for an x86 laptop on anything
> but x86 ?    Ie, why not just add a dependancy in the Kconfig
> so you don't have to add ifdefs to the code ?
> 

lifebook is a part of psmouse driver and is presenty not selectable on
its own.

-- 
Dmitry
