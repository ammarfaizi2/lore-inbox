Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbTGTXDW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbTGTXDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:03:22 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:1542 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S268812AbTGTXDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:03:17 -0400
Date: Mon, 21 Jul 2003 01:18:47 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: About include/linux/nls.h
Message-ID: <20030720231847.GA2172@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :)

    I was tweaking my GCC installation and, once again, I noticed
that the header include/linux/nls.h was being 'fixincluded'. The
problem, a supposedly missing '#ifndef __cplusplus'.

    Since this is the only fixincluded header, couldn't it be fixed
(I can make the patch, if necessary). I know, the kernel is C and not
C++, maybe the GCC people is a little 'tricky' when using
fixincludes, etc... but the change is small and is the only one
needed in the entire kernel in order to make GCC happy and get rid of
that fixinugly thingie ;)) I don't want to start a troll about this
issue, but I would like to know the opinion of the kernel people.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
