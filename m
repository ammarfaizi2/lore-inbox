Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbTBDVuV>; Tue, 4 Feb 2003 16:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTBDVuV>; Tue, 4 Feb 2003 16:50:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16535
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267497AbTBDVuU>; Tue, 4 Feb 2003 16:50:20 -0500
Subject: RE: PnP model
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: John Bradford <john@grabjohn.com>, ambx1@neo.rr.com, perex@perex.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A154@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A154@orsmsx401.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044399393.29825.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Feb 2003 22:56:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-04 at 19:53, Grover, Andrew wrote:
> Ok fair enough. But I think the drivers should always think things are
> handled in a PnP manner, even if they really aren't. ;-) For example,

If this was a post 2.6 argument I would agree. The notion of removing all the
horribly resource code and having ISA legacy drivers probe code do

	my_dev = isa_create_device(&resourceinfo, "soundblaster16");
	my_dev->set_irq = foo;

etc type stuff is nice

