Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWBJBwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWBJBwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 20:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWBJBwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 20:52:38 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:8204 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1750980AbWBJBwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 20:52:37 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 9 Feb 2006 20:52:02 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, Martin Mares <mj@ucw.cz>,
       peter.read@gmail.com, Matthias Andree <matthias.andree@gmx.de>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210015201.GP18918@voodoo>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Martin Mares <mj@ucw.cz>, peter.read@gmail.com,
	Matthias Andree <matthias.andree@gmx.de>,
	LKML Kernel <linux-kernel@vger.kernel.org>
References: <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <mj+md-20060209.095744.7127.atrey@ucw.cz> <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/06 06:14:40PM -0500, Kyle Moffett wrote:
> Does cdrecord talk to CPU devices? No! Why do you care?  BTW: What  
> the hell is a "CPU device" and why the hell would you think you could  
> talk to it through a disk interface, let alone some other random SCSI  
> interface?
> 

We have several fiber controllers and the controller itself does show up as
a SCSI device that sg can bind to, I believe the management software can
actually manage the storage via that node but we've never used it and I
highly doubt anyone uses cdrecord or libscg for that purpose.

Jim.
