Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbTCMO0m>; Thu, 13 Mar 2003 09:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbTCMO0m>; Thu, 13 Mar 2003 09:26:42 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12238
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262364AbTCMO0l>; Thu, 13 Mar 2003 09:26:41 -0500
Subject: Re: Linux BUG: Memory Leak
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Stevenson <james@stev.org>
Cc: pd dd <parviz_kernel@yahoo.com>, "M. Soltysiak" <msoltysiak@hotmail.com>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
In-Reply-To: <01f801c2e96c$980b4390$0cfea8c0@ezdsp.com>
References: <20030313091315.14044.qmail@web20504.mail.yahoo.com>
	 <01f801c2e96c$980b4390$0cfea8c0@ezdsp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047570333.25944.42.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Mar 2003 15:45:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 14:26, James Stevenson wrote:
> this isnt a serious problem then ?

There were problems with the XFree 4.3 DRM if you mixed it with
certain other ingredients like rmap. I don't know what Slackware
ships but that may be the problem.

With a base kernel + XFree 4.3 DRM port the only problems I'm now
hitting are serious breakages in the DRM code causing memory
corruption on Radeon 9x00 and the fact 4.3 broke SiS DRM support.

