Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVI3Sgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVI3Sgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVI3Sgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:36:48 -0400
Received: from emulex.emulex.com ([138.239.112.1]:24815 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S965052AbVI3Sgr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:36:47 -0400
From: James.Smart@Emulex.Com
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx intothe kernel
Date: Fri, 30 Sep 2005 14:36:15 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F46D5@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: I request inclusion of SAS Transport Layer and AIC-94xx intothe kernel
Thread-Index: AcXF6ACKhd2iYj20Ql24wytPvJC4LAABWJmQ
To: <arjan@infradead.org>, <mark_salyzyn@adaptec.com>
Cc: <Luben_Tuikov@adaptec.com>, <andrew.patterson@hp.com>, <dougg@torque.net>,
       <torvalds@osdl.org>, <ltuikov@yahoo.com>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2005-09-30 at 13:07 -0400, Salyzyn, Mark wrote:
> > At the SAS BOF, I indicated that it would not be much trouble to
> > translate the CSMI handler in the aacraid driver to a similar sysfs
> > arrangement. If such info can be mined from a firmware 
> based RAID card,
> > every driver should be able to do so. The spec writers 
> really need to
> > consider rewriting SDI for sysfs (if they have not already) and move
> > away from an ABI.
> 
> that makes me wonder... why and how does T10 control linux abi's ??

Agreed. The most they should be doing is defining a library interface, and
letting the library hide the system specifics (like t11 and hbaapi, who
still got parts wrong).  It also changes the argument from being a "linux abi"
to being "a defacto application/library abi". 

-- james s
