Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUG2SA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUG2SA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUG2R5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:57:39 -0400
Received: from falcon.csc.calpoly.edu ([129.65.242.5]:37800 "EHLO
	falcon.csc.calpoly.edu") by vger.kernel.org with ESMTP
	id S267553AbUG2R4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:56:15 -0400
Date: Thu, 29 Jul 2004 10:33:29 -0700
From: Ben Fennema <bfennema@falcon.csc.calpoly.edu>
To: David Balazic <david.balazic@hermes.si>
Cc: "'Pat LaVarre'" <p.lavarre@ieee.org>, "'David Burg'" <dburg@nero.com>,
       linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Can not read UDF CD
Message-ID: <20040729173329.GA16555@falcon.csc.calpoly.edu>
References: <B1ECE240295BB146BAF3A94E00F2DBFF090205@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1ECE240295BB146BAF3A94E00F2DBFF090205@piramida.hermes.si>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 06:32:13PM +0200, David Balazic wrote:
> Just ask if you need any more info.
> I will try to see if the problem is reproducable with burning
> more UDF CDs... ( I guess the UDF part of Nero is not
> as widely used as ISO9660 )

Try mounting with -o session=0 (or something like that).
It's comming up with some totally random 2nd session in the middle of the
disc and trying to mount that.

Ben
