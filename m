Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129804AbRB0LBF>; Tue, 27 Feb 2001 06:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRB0LAz>; Tue, 27 Feb 2001 06:00:55 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:14858 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129791AbRB0LAl>; Tue, 27 Feb 2001 06:00:41 -0500
Date: Tue, 27 Feb 2001 11:56:50 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: David <dllorens@lsi.uji.es>, linux-kernel@vger.kernel.org
Subject: Re: Posible bug in gcc
Message-ID: <20010227115649.H25658@arthur.ubicom.tudelft.nl>
In-Reply-To: <3A9A8489.224CF54C@inf.uji.es> <20010226233013.A2995@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010226233013.A2995@werewolf.able.es>; from jamagallon@able.es on Mon, Feb 26, 2001 at 11:30:13PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 11:30:13PM +0100, J . A . Magallon wrote:
> On 02.26 David wrote:
> > I think I heve found a bug in gcc. I have tried both egcs 1.1.2 (gcc
> > 2.91.66) and gcc 2.95.2 versions.
> 
> gcc2.95.2 is sane in irix6.2, irix6.5 and solaris7sparc.
> 
> The optimizer is not in the common front-end ?

Yes and no. There is some common code in the optimiser, but each target
has its own optimisation tricks for which the code is not shared with
other targets.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
