Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288480AbSAIEhV>; Tue, 8 Jan 2002 23:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288783AbSAIEhL>; Tue, 8 Jan 2002 23:37:11 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:64014 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288480AbSAIEg7>;
	Tue, 8 Jan 2002 23:36:59 -0500
Date: Tue, 8 Jan 2002 20:34:47 -0800
From: Greg KH <greg@kroah.com>
To: felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109043446.GB17655@kroah.com>
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109042331.GB31644@codeblau.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 05:23:31AM +0100, Felix von Leitner wrote:
> 
> How many programs are we talking about here?  And what should they do?

Very good question that we should probably answer first (I'll follow up
to your other points in a separate message).

Here's what I want to have in my initramfs:
	- /sbin/hotplug
	- /sbin/modprobe
	- modules.dep (needed for modprobe, but is a text file)

What does everyone else need/want there?

greg k-h
