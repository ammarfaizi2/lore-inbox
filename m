Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVFOWtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVFOWtf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVFOWtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:49:32 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:24511 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261619AbVFOWtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:49:17 -0400
Date: Wed, 15 Jun 2005 18:48:56 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: serue@us.ibm.com
cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
       Toml@us.ibm.com, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
       Reiner Sailer <sailer@watson.ibm.com>, Emilyr@us.ibm.com,
       Kylene@us.ibm.com
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <Pine.WNT.4.63.0506151844370.2452@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Serge E. Hallyn (serue@us.ibm.com) wrote:
>
> That's true, of course.  Reiner, would any of the integrity measurement
> hooks be moved to a better place than the current LSM hooks?  Is there a
> preferred ordering - ie measurement should always happen before the LSM
> modules, or always after?  Either of these would of course be clear
> reasons to separate IMA into its own subsystem.
> 
> thanks,
> -serge

Originally, IMA was not an LSM. However, when moving to a 2.6 kernel, we 
moved it to LSM and have found very easily the current hooks. I don't think 
the hook position would change when moving from LSM to non-LSM.

Thanks
Reiner

