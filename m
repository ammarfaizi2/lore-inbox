Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132918AbRDETop>; Thu, 5 Apr 2001 15:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132935AbRDETof>; Thu, 5 Apr 2001 15:44:35 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:1042 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S132918AbRDETo1>; Thu, 5 Apr 2001 15:44:27 -0400
Date: Thu, 5 Apr 2001 21:41:36 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Johan Adolfsson <johan.adolfsson@axis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Arch specific/multiple Configure.help files?
Message-ID: <20010405214136.X18749@arthur.ubicom.tudelft.nl>
In-Reply-To: <200103262233.f2QMXqm21750@snark.thyrsus.com> <18a601c0bdf5$d7305500$0a070d0a@axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <18a601c0bdf5$d7305500$0a070d0a@axis.se>; from johan.adolfsson@axis.com on Thu, Apr 05, 2001 at 07:28:33PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2001 at 07:28:33PM +0200, Johan Adolfsson wrote:
> Would it be a good idea to have support for multiple Configure.help
> files in the config system?
> The main advantage would be that arch specific settings could
> have an arch specific help file as well.

I don't see why this would be an advantage. IMHO Documentation belongs
in the Documentation tree and configuration documentation belongs in
Configure.help. You almost never read that file yourself, only the
various kernel configure tools read it, and tools don't have a problem
with large files. It's better to have the documentation at a single
point, not scattered around in the kernel tree.

> Anybody who knows: Would it be a easy to add support for this if 
> this is considered a good idea?

Shouldn't be too hard.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
