Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVJGO7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVJGO7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbVJGO7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:59:35 -0400
Received: from fmr20.intel.com ([134.134.136.19]:14727 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030294AbVJGO7e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:59:34 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Date: Fri, 7 Oct 2005 07:59:22 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470B74E1F0@orsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Thread-Index: AcXLOZ96aZ4BlHTjQeqzg7CQnh5VngAFcxHw
From: "Gross, Mark" <mark.gross@intel.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Mark Gross" <mgross@linux.intel.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <Sebastien.Bouchard@ca.kontron.com>
X-OriginalArrivalTime: 07 Oct 2005 14:59:24.0163 (UTC) FILETIME=[B4888D30:01C5CB4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
>Sent: Friday, October 07, 2005 5:21 AM
>To: Mark Gross
>Cc: akpm@osdl.org; linux-kernel@vger.kernel.org;
Sebastien.Bouchard@ca.kontron.com; Gross, Mark
>Subject: Re: Telecom Clock Driver for MPCBL0010 ATCA computer blade
>
>On 10/6/05, Mark Gross <mgross@linux.intel.com> wrote:
>> On Thursday 06 October 2005 09:52, Jesper Juhl wrote:
>> > > +This directory exports the following interfaces.  There
opperation is documented
>
>Btw, please spell "operation" correctly :)
>
>[snip]
>> > > +  printk(KERN_ERR" misc_register retruns %d \n", ret);
>
>Space between 'KERN_ERR" and '"' please.
>

Ok, I got them both.

I'm now fighting with GKH's request to use sysfs_create_group.  I'm not
sure it will work with a misc class device, as its written for the more
common bus based device objects in mind.

Once I get the Greg issue figured out I'll have a new post with all the
updates to make folks happy.

--mgross

