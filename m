Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319314AbSIKUB1>; Wed, 11 Sep 2002 16:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319311AbSIKUBP>; Wed, 11 Sep 2002 16:01:15 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:5860 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S319314AbSIKUAx>; Wed, 11 Sep 2002 16:00:53 -0400
Subject: Re: the userspace side of driverfs
From: Nicholas Miell <nmiell@attbi.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <almpmt$rmi$1@ncc1701.cistron.net>
References: <1031707119.1396.30.camel@entropy>
	<Pine.LNX.4.44.0209102122520.1057-100000@cherise.pdx.osdl.net> 
	<almpmt$rmi$1@ncc1701.cistron.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 13:05:31 -0700
Message-Id: <1031774732.1499.1.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 00:00, Miquel van Smoorenburg wrote:
> If you have multiple values per file, why not make it a directory with
> multiple files in it, each with one value per file.
> 

But subdirectories are child devices. Having array directories and
device directories would complicate the apps that have to parse this
data.
 
- Nicholas

