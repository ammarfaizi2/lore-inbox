Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTDWWCr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTDWWCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:02:47 -0400
Received: from almesberger.net ([63.105.73.239]:13318 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264231AbTDWWCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:02:46 -0400
Date: Wed, 23 Apr 2003 19:14:27 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423191427.D3557@almesberger.net>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560860000.1051133781@flay>; from mbligh@aracnet.com on Wed, Apr 23, 2003 at 02:36:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> I'm more concerned with new installs, and the poor user having no idea
> why his sound card "doesn't work". Been there myself. Pain in the ass.

Yes, but that's a user space problem too. Nothing prevents your
distribution to crank up the volume to 100% also on a first-time
installation.

The kernel should pick a value that's safe in all cases. And
this is zero. Don't forget that there can be several seconds
between the driver's initialization and the moment when the
user-space utility gets to change the settings.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
