Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132898AbRDWMAj>; Mon, 23 Apr 2001 08:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132958AbRDWMA3>; Mon, 23 Apr 2001 08:00:29 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:7400 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132898AbRDWMAY>; Mon, 23 Apr 2001 08:00:24 -0400
From: Christoph Rohland <cr@sap.com>
To: "David L. Parsley" <parsley@linuxjedi.org>
Cc: linux-kernel@vger.kernel.org, ingo.oeser@informatik.tu-chemnitz.de,
        viro@math.psu.edu
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <3AE307AD.821AB47C@linuxjedi.org>
Organisation: SAP LinuxLab
Date: 23 Apr 2001 13:43:27 +0200
Message-ID: <m3r8yjrgdc.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sun, 22 Apr 2001, David L. Parsley wrote:
> I'm still working on a packaging system for diskless
> (quasi-embedded) devices.  The root filesystem is all tmpfs, and I
> attach packages inside it.  Since symlinks in a tmpfs filesystem
> cost 4k each (ouch!), I'm considering using mount --bind for
> everything.

What about fixing tmpfs instead?

Greetings
		Christoph


