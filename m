Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131820AbRC1NCm>; Wed, 28 Mar 2001 08:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131823AbRC1NCf>; Wed, 28 Mar 2001 08:02:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35851 "EHLO www.linux.org.uk") by vger.kernel.org with ESMTP id <S131819AbRC1NBp>; Wed, 28 Mar 2001 08:01:45 -0500
Date: Wed, 28 Mar 2001 14:00:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
Message-ID: <20010328140057.A6867@flint.arm.linux.org.uk>
References: <Pine.LNX.4.30.0103280225460.8046-100000@coredump.sh0n.net> <01032806093901.11349@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01032806093901.11349@tabby>; from jesse@cats-chateau.net on Wed, Mar 28, 2001 at 06:08:15AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 06:08:15AM -0600, Jesse Pollard wrote:
> Sure - very simple. If the execute bit is set on a file, don't allow
> ANY write to the file. This does modify the permission bits slightly
> but I don't think it is an unreasonable thing to have.

Even easier method - remove the write permission bits from all executable
files, and don't do the unsafe thing of running email/web browsers/other
user-type stuff as user root.

If it still worries you that root can write to files without the 'w' bit
set, modify the capabilities of the system to prevent it (there is a bit
that can be set which will remove this ability for all new processes).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

