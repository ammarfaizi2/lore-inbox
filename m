Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267800AbTBNXF4>; Fri, 14 Feb 2003 18:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267815AbTBNXF4>; Fri, 14 Feb 2003 18:05:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12417
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267800AbTBNXF4>; Fri, 14 Feb 2003 18:05:56 -0500
Subject: Re: WBEM and WMI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Simoneaux, Jill" <jill.simoneaux@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <B34A7DC9C1CDAB4D9A4BC2C0F15A06E83ACA99@fmsmsx401.fm.intel.com>
References: <B34A7DC9C1CDAB4D9A4BC2C0F15A06E83ACA99@fmsmsx401.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045268160.1854.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 15 Feb 2003 00:16:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 22:54, Simoneaux, Jill wrote:
> Are there any plans for incorporating WBEM into the kernel??

Why would it need to be in the kernel ? We already handle things like DMI
table scanning almost entirely in user space (we just touch it in kernel
at boot to look for hardware signatures indicating problems)

