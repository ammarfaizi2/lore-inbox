Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTABEvC>; Wed, 1 Jan 2003 23:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTABEvC>; Wed, 1 Jan 2003 23:51:02 -0500
Received: from are.twiddle.net ([64.81.246.98]:6019 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265667AbTABEvA>;
	Wed, 1 Jan 2003 23:51:00 -0500
Date: Wed, 1 Jan 2003 20:58:36 -0800
From: Richard Henderson <rth@twiddle.net>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ak@suse.de,
       paulus@samba.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] Modules 3/3: Sort sections
Message-ID: <20030101205836.A30574@twiddle.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	rusty@rustcorp.com.au, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ak@suse.de,
	paulus@samba.org, rmk@arm.linux.org.uk
References: <20030102030044.D066C2C05E@lists.samba.org> <20030101205404.B30272@twiddle.net> <20030101.205003.37279830.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030101.205003.37279830.davem@redhat.com>; from davem@redhat.com on Wed, Jan 01, 2003 at 08:50:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 08:50:03PM -0800, David S. Miller wrote:
>    Incidentally, why do we do strstr(name, ".init") instead
>    of strncmp(name, ".init", 5)?  Is there any particular
>    need for the .init to come at the end?
> 
> I think this is to get .foo.init sections.

Obviously.  Perhaps the question was worded badly.  Instead read
it as "Why don't we force this to be called .init.foo instead?"


r~
