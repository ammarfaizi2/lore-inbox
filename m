Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbSLSBFQ>; Wed, 18 Dec 2002 20:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbSLSBFP>; Wed, 18 Dec 2002 20:05:15 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:21766
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267507AbSLSBFO>; Wed, 18 Dec 2002 20:05:14 -0500
Subject: RE: 15000+ processes -- poor performance ?!
From: Robert Love <rml@tech9.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Till Immanuel Patzschke'" <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CACA2C@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA2C@orsmsx116.jf.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040260387.855.95.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 20:13:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 20:04, Perez-Gonzalez, Inaky wrote:
> > 
> > forgot the kernel version (2.4.20aa1)...
> 
> You need the O(1) scheduler; not sure if aa has it or not; if not, lots of
> processes will suck your machine. I think -ac has the O(1) scheduler, or try
> 2.5. The old scheduler is pretty cool but not as scalable as the new one.
> 
> If it has it ... well, I have no idea - maybe Robert Love would
> know.

2.4-aa has the O(1) scheduler, yes.

I think 15,000 processes may always suck, though :)

	Robert Love


