Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSHVRTA>; Thu, 22 Aug 2002 13:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSHVRTA>; Thu, 22 Aug 2002 13:19:00 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:36617 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S314529AbSHVRS7>;
	Thu, 22 Aug 2002 13:18:59 -0400
Date: Thu, 22 Aug 2002 19:31:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is kernel compilation supposed to change header file timestamps?
Message-ID: <20020822193156.B1401@mars.ravnborg.org>
Mail-Followup-To: Chris Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
References: <3D65142F.116481FB@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D65142F.116481FB@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Thu, Aug 22, 2002 at 12:41:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 12:41:19PM -0400, Chris Friesen wrote:
> 
> I noticed the other day that on a kernel compile, the timestamps of some files are changed.  The
> funny thing is that all the changed ones are header files, but not all header files are modified.
> 
> Is this expected behaviour?
I assume you are compiling a 2.4 kernel, in which case this is expected
behaviour.
For the 2.5 kernel kbuild has been changed such that 
header files are no longer 'touched' during the compile process.

	Sam
