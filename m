Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbRELNoi>; Sat, 12 May 2001 09:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261248AbRELNo2>; Sat, 12 May 2001 09:44:28 -0400
Received: from m2ep.pp.htv.fi ([212.90.64.98]:38162 "EHLO m2.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S261247AbRELNoV>;
	Sat, 12 May 2001 09:44:21 -0400
Message-ID: <3AFD3E71.924FBD82@tyrell.hu>
Date: Sat, 12 May 2001 16:45:21 +0300
From: Akos Maroy <darkeye@tyrell.hu>
Organization: Tyrell Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Process accessing a Sony DSC-F505V camera through USB as a 
 storage device hangs.
In-Reply-To: <3AFD2E41.213CFB47@tyrell.hu> <20010512151803.C8826@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> 
> On Sat, May 12, 2001 at 03:36:17PM +0300, Akos Maroy wrote:
> > [1.] One line summary of the problem:
> >
> > Process accessing a Sony DSC-F505V camera through USB as a storage
> > device hangs.
> 
> [snip]
> 
> > [7.3.] Module information (from /proc/modules):
> >
> > NVdriver              629488  12 (autoclean)
> > usb-storage            48928   1
> > uhci                   23680   0 (unused)
> > usbcore                53008   0 [usb-storage uhci]
> > nls_iso8859-1           2864   4 (autoclean)
> > nls_cp437               4384   4 (autoclean)
> > vfat                    9328   4 (autoclean)
> > fat                    32160   0 (autoclean) [vfat]
> 
> You're using the binary only NVdriver. Boot the system without that
> driver and try to recreate the problem. If not, you'll have to contact
> nvidia.

I tried, and the same problem persists.


Akos
