Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTF3Nse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 09:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTF3Nse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 09:48:34 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264083AbTF3Ns3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 09:48:29 -0400
Date: Mon, 30 Jun 2003 15:11:08 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306301411.h5UEB8uL000195@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, reiser@namesys.com
Subject: Re: File System conversion -- ideas
Cc: jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org, mlmoser@comcast.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tend to agree with the below.  I just want to add though that there 
> are a lot of users who have one disk drive and and no decent network 
> connection to somewhere with a lot of storage.  It would be nice to 
> adapt tar to understand about the reiser4 resizer and mkreiser4 and the 
> reiser3 resizer, and the partitioner (yah, at this point it would no 
> longer really be tar, but.... ), and to have it shrink the V3 partition, 
> create a reiser4 partition, copy some of the V3 partition to the V4 
> partition, shrink the V3 partition some more, etc.....

Out of interest, won't the resulting filesystem be excessively
fragmented, and cause worse performance than a virgin filesystem, or
does the reiser resizer actively prevent that?

John.
