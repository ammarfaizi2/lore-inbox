Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268962AbTCARlQ>; Sat, 1 Mar 2003 12:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268965AbTCARlQ>; Sat, 1 Mar 2003 12:41:16 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:56735 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268962AbTCARlP>; Sat, 1 Mar 2003 12:41:15 -0500
Date: Sat, 1 Mar 2003 17:51:14 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org, akpm@zip.com.au, slpratt@austin.ibm.com,
       levon@movementarian.org, haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <20030301175114.GA30911@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	cliffw@osdl.org, akpm@zip.com.au, slpratt@austin.ibm.com,
	levon@movementarian.org, haveblue@us.ibm.com
References: <8550000.1046419962@[10.10.2.4]> <20030228002935.256ffa98.akpm@digeo.com> <20030228112238.GJ4911@codemonkey.org.uk> <20030228152838.GB32449@gtf.org> <20010101052723.GB22212@krispykreme> <447430000.1046473881@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447430000.1046473881@flay>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 03:11:21PM -0800, Martin J. Bligh wrote:
 > +start daemon	opcontrol --start-daemon

--start implies starting the daemon if it isn't started
already.

 > +stop		opcontrol --stop

--stop unsupported. use "--shutdown"

 > +dump output	oprofpp -dl -i /boot/vmlinux  >  output_file

opcontrol --dump

op_time -l is also worth adding to this doc imo.

        Dave

