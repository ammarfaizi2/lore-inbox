Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279893AbRKFSjt>; Tue, 6 Nov 2001 13:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279943AbRKFSjj>; Tue, 6 Nov 2001 13:39:39 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:9709
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S279893AbRKFSjY>; Tue, 6 Nov 2001 13:39:24 -0500
Date: Tue, 6 Nov 2001 19:39:15 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: John Summerfield <summer@os2.ami.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Olivetti hangs in PCI initialisation
Message-ID: <20011106193915.A821@jaquet.dk>
In-Reply-To: <200111061706.fA6H6CK11522@numbat.os2.ami.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111061706.fA6H6CK11522@numbat.os2.ami.com.au>; from summer@os2.ami.com.au on Wed, Nov 07, 2001 at 01:06:11AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 01:06:11AM +0800, John Summerfield wrote:
> 
> 
> It's bizarre. The machine boots okay with the Red Hat Linux bootnet 
> image for RHL 7.2, and starts running the installer - the the point of 
> configuring my network card.
> 
> It was hanging at the point where I saw the message "PCI: Using 
> configuration type 1."

Hi.

Some time ago I had an old Pentium Olivetti die on me during boot
in pci-country. I could work around that with the boot parameter
'pci=conf1'. You seem to die in conf1. Maybe you should try out
conf2 and see what happens?
-- 
        Rasmus(rasmus@jaquet.dk)

intoxicated, adj.: When you feel sophisticated without being able to 
pronounce it. 
