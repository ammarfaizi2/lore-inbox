Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbRF1HxO>; Thu, 28 Jun 2001 03:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265593AbRF1HxE>; Thu, 28 Jun 2001 03:53:04 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:16138 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S265592AbRF1Hws>; Thu, 28 Jun 2001 03:52:48 -0400
Date: Thu, 28 Jun 2001 08:47:03 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
Message-ID: <20010628084703.B27891@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3B395FE5.1070208@zytor.com> <200106272055.f5RKtur331470@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106272055.f5RKtur331470@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Wed, Jun 27, 2001 at 04:55:56PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 04:55:56PM -0400, Albert D. Cahalan wrote:
> ln /dev/zero /tmp/zero
> ln /dev/hda ~/hda
> ln /dev/mem /var/tmp/README

None of these (of course) work if you use mount options to restrict device
nodes on those filesystems.

Sean
