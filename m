Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319528AbSIGWBj>; Sat, 7 Sep 2002 18:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319529AbSIGWBj>; Sat, 7 Sep 2002 18:01:39 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44297
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319528AbSIGWBj>; Sat, 7 Sep 2002 18:01:39 -0400
Date: Sat, 7 Sep 2002 15:05:12 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Daniel Egger <degger@fhm.edu>
cc: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
In-Reply-To: <1031429984.2723.29.camel@sonja.de.interearth.com>
Message-ID: <Pine.LNX.4.10.10209071458540.16589-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Sep 2002, Daniel Egger wrote:

> Am Sam, 2002-09-07 um 17.02 schrieb jbradford@dial.pipex.com:
> 
> > No, but you've upgraded the firmware, right?
> 
> Not exactly. According to IBM technical support there is no such thing
> as a new firmware. The drives are alright, the OS is broken.

They are full of CRAP!

IBM ran TASKFILE IO throught there bus analyzers and it came up clean.
IBM also introduced FLAGGED versions of the diagnostic TASKFILE transport
for eventual use of their DFT (Drive Fitness Test).

You tell the service tech he is smoking crack.
The kernel passed with flying colors in their disk labs. If you read
in ide-taskfile.c version 0.33 and above, you will see they did some work
on the driver and verified issues.

Now earlier I published a method of how to stablize the drive once you
back up all the data you can off of it.  Since I do not yet have a source
verison of DFT-Linux, or binary yet, I can not offer much more native.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

