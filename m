Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262386AbSI2DsJ>; Sat, 28 Sep 2002 23:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSI2DsJ>; Sat, 28 Sep 2002 23:48:09 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:519 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S262386AbSI2DsI>;
	Sat, 28 Sep 2002 23:48:08 -0400
Date: Sun, 29 Sep 2002 04:53:23 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] oprofile for 2.5.39
Message-ID: <20020929035323.GA69342@compsoc.man.ac.uk>
References: <20020929014440.GA66796@compsoc.man.ac.uk.suse.lists.linux.kernel> <p737kh5sf45.fsf@oldwotan.suse.de> <20020929025224.GA68153@compsoc.man.ac.uk> <20020929050807.A17869@wotan.suse.de> <3D9677BA.110E5AB3@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9677BA.110E5AB3@digeo.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17vV91-000447-00*XCsBPVk6CBo* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 08:47:06PM -0700, Andrew Morton wrote:

> Using smp_processor_id() is usually a bug.

Well, this is in-interrupt code.

> - If you do something which might sleep inside get_cpu/put_cpu,
>   you get might_sleep() warnings.

Certainly handy (but I don't see it's useful in this particular code,
really)

regards
john

-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
