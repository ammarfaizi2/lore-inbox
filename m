Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbSKVVGi>; Fri, 22 Nov 2002 16:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264659AbSKVVGi>; Fri, 22 Nov 2002 16:06:38 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:20230 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264649AbSKVVGh>; Fri, 22 Nov 2002 16:06:37 -0500
From: "Helge Hafting" <helgehaf@idb.hist.no>
Date: Fri, 22 Nov 2002 22:14:01 +0100
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48-bk4 still impossible to mount root.
Message-ID: <20021122211401.GA4549@hh.idb.hist.no>
References: <3DDE67DB.C66E43D3@aitel.hist.no> <1037994156.11829.9.camel@home.ldb.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037994156.11829.9.camel@home.ldb.ods.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 08:42:37PM +0100, Luca Barbieri wrote:
> On Fri, 2002-11-22 at 18:22, Helge Hafting wrote:
> > None of the 2.5.48- bk or mm kernels lets me mount root,
> > while 2.5.47 works fine.
> 
> You have to use the long devfs name, e.g. rather than /dev/hda1 use
> /dev/ide/host0/bus0/target0/lun0/part1.
> 
What do you mean? My lilo.conf obviously uses the "long"
names, because the short ones doesn't exist. It has
been like that since I started using devfs long ago.

The kernel don't deal in names when it tries to mount root though,
it tries to mount device 03:04 or 09:00

That works with 2.5.47 and all earlier 2.5 kernels, but not 2.5.48.

Helge Hafting

