Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTLJP4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTLJP4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:56:12 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:27784 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S263662AbTLJP4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:56:06 -0500
Date: Wed, 10 Dec 2003 15:55:53 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Joe Thornber <thornber@sistina.com>, linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
In-Reply-To: <1258280000.1071024272@[10.10.2.4]>
Message-ID: <Pine.LNX.4.56.0312101547590.1218@fogarty.jakma.org>
References: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet>
 <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org> <1258280000.1071024272@[10.10.2.4]>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Martin J. Bligh wrote:

> Some form of backward compatibility from 2.6 would seem a much more
> sensible thing to fight for. Foisting forward comaptibility on an
> older release seems like a bad road to go down.

I dont really care, but some kind of (long-term, ie lifetime of 
either 2.4 or 2.6) compatibility is needed.

LVM1 kernel support was recently removed from 2.6.0, so it would have 
to be added back in. 

One argument for adding forward compatibility in 2.4 is that it will 
/force/ people to move to DM before going to 2.6, which might be a 
good thing as, AIUI, LVM1 has problems. 

Its a choice between:

- 2.6 backwards compatibility, adding back in LVM1 support, LVM1 
users will then quite possibly continue to use the problematical LVM1 
interfaces even after migrating to 2.6.

- 2.4 forwards compatibility, add DM support - which appears (IMVU)  
to drop in cleanly alongside MD - and hence 2.6 can remain 'clean'.

I dont know, but it would be nice to have /something/ and to have it 
in stock kernel rather than /hope/ to have upstreams include the 
required backward or forward compatibility.

> M.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
But it does move!
		-- Galileo Galilei
