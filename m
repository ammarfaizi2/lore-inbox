Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRJXOWb>; Wed, 24 Oct 2001 10:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274544AbRJXOWV>; Wed, 24 Oct 2001 10:22:21 -0400
Received: from NS.iNES.RO ([193.230.220.1]:23504 "EHLO Master.iNES.RO")
	by vger.kernel.org with ESMTP id <S273588AbRJXOWM>;
	Wed, 24 Oct 2001 10:22:12 -0400
Subject: Re: Two suggestions (loop and owner's of linux tree)
From: Dumitru Ciobarcianu <cioby@ines.ro>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110241605020.12884-100000@oceanic.wsisiz.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0110241605020.12884-100000@oceanic.wsisiz.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 24 Oct 2001 17:21:18 +0300
Message-Id: <1003933278.1496.6.camel@LNX.iNES.RO>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2001-10-24 at 17:13, Lukasz Trabinski wrote:
> Hello
> 
> I would like to suggest to change max_loop from 8 to 16 or more if it
> possible.

max_loop=16 in your kernel command line if you use loop builtin or:
options loop max_loop=16 in /etc/modules.conf if you use it as an
module.

> My second suggestions is a request for change owner linux tree from 1046 
> uid and 101 gid to 0.0 for security reason.  

chmod -R root.root linux/ 
after you have unpacked the tarball.

//Cioby



