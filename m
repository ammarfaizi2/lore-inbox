Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTD3PQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTD3PQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:16:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9878
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262269AbTD3PP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:15:58 -0400
Subject: Re: IBM x440 problems on 2.4.20 to 2.4.20-rc1-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wojciech Sobczak <Wojciech.Sobczak@comarch.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <01d601c30f17$f3ffadf0$b312840a@nbsobczak>
References: <01d601c30f17$f3ffadf0$b312840a@nbsobczak>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051712978.19573.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Apr 2003 15:29:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-30 at 13:56, Wojciech Sobczak wrote:
> with NUMA support and summit/exa support and clustered apic support kernel
> boots, found scsi devices but hangs on it with lost interruption, also with
> ide devices and so on

That sounds like a bug. Make sure you ACPI off for x440 if you are
testing and see if that helps


For vendor kernels you need Red Hat AS 2.1 or UnitedLinux 1.0. At least
I don't believe other vendors rolled kernels for x440 but I may be wrong
about that - certainly I can believe Debian or Gentoo might have.

x440 is sufficiently weird it needs its own extras and that makes it
hard to support for vendors.

Alan

