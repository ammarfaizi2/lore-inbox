Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263381AbSJFKxn>; Sun, 6 Oct 2002 06:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263383AbSJFKxn>; Sun, 6 Oct 2002 06:53:43 -0400
Received: from brev.stud.ntnu.no ([129.241.56.70]:3301 "EHLO brev.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S263381AbSJFKxm>;
	Sun, 6 Oct 2002 06:53:42 -0400
Date: Sun, 6 Oct 2002 12:59:17 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021006105917.GB13046@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <20021005090705.GA18475@stud.ntnu.no> <1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond> <20021005235614.GC25827@stud.ntnu.no> <20021006021802.GA31878@pegasys.ws> <1033871869.1247.4397.camel@phantasy> <20021006024902.GB31878@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021006024902.GB31878@pegasys.ws>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz:
> I stand corrected.  The load average reported will reflect
> them.  The D-state processes, however, will have nearly zero
> effect on the system performance, yes?  So in this case the
> load average reported is simply an infated number.

They won't have any effect on the system, but the load number is
insane (we have a 2 CPU intel-boks with a load number of 480)
and there's like 200-300 (or more) processes hanging in D-state
with they're FD's and stuff. There _really_ should be a way
to remove all theese processes, Solaris does this nicely.

-- 
Thomas
