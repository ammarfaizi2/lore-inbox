Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318046AbSFSWxB>; Wed, 19 Jun 2002 18:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSFSWxA>; Wed, 19 Jun 2002 18:53:00 -0400
Received: from ns.suse.de ([213.95.15.193]:19217 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318046AbSFSWw7>;
	Wed, 19 Jun 2002 18:52:59 -0400
Date: Thu, 20 Jun 2002 00:52:59 +0200
From: Dave Jones <davej@suse.de>
To: Scott Tillman <tillman@viewcast.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Garet Cammer <arcolin@arcoide.com>, linux-kernel@vger.kernel.org
Subject: Re: Need IDE Taskfile Access
Message-ID: <20020620005259.V29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Scott Tillman <tillman@viewcast.com>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Garet Cammer <arcolin@arcoide.com>, linux-kernel@vger.kernel.org
References: <3D1038CC.3090108@evision-ventures.com> <CBELJEJGBEIGHCIMEDHNCEPBCIAA.tillman@viewcast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CBELJEJGBEIGHCIMEDHNCEPBCIAA.tillman@viewcast.com>; from tillman@viewcast.com on Wed, Jun 19, 2002 at 06:43:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 06:43:57PM -0400, Scott Tillman wrote:
 > I'm working with a group of people in an effort to get Linux running on the
 > XBox.  The XBox uses a set of security PIO commands to restrict access to
 > the IDE drive, requiring a 32 byte password to be delivered before sector
 > access is allowed.
 > 
 > Another comment/question (related to XBox support):
 > As part of this effort the xbox-linux team has coded support for the XBox's
 > proprietary partitioning and it's new filesystem.  This code (and any
 > further kernel support code) has been developed for the 2.4.18 kernel, and
 > we have no desire to port it to 2.5.x unless there is some hope of it's
 > adoption.  Could I get an official decision on whether this code might be
 > adopted if made available to the 2.5.x kernel?

I wonder about the legality of including such a port in the mainline kernel.
The IDE restriction sounds like it definitly comes under the
'circumventing an access control' clause of the DMCA.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
