Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRBMVWr>; Tue, 13 Feb 2001 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129793AbRBMVWi>; Tue, 13 Feb 2001 16:22:38 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:30862 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130487AbRBMVW2>; Tue, 13 Feb 2001 16:22:28 -0500
Date: Tue, 13 Feb 2001 21:22:26 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca>
Message-ID: <Pine.SOL.4.21.0102132119530.1900-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Jeremy Jackson wrote:

(Long description of how to create a non-executable stack on x86)

I'm afraid you just reinvented the wheel. The idea has been around for a
long time, and it was OK as a quick hack to stop existing exploits
working, but it's possible to modify a buffer overflow exploit to work
around this.

It does sound look like a good idea, but it doesn't really gain you
anything in the long run: the exploits just change a bit.

ISTR there is a patch which does this for Linux, though??


James.

