Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265922AbUFIU2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUFIU2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUFIU2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:28:50 -0400
Received: from aun.it.uu.se ([130.238.12.36]:50611 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265922AbUFIU2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:28:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16583.29432.400199.699683@alkaid.it.uu.se>
Date: Wed, 9 Jun 2004 22:28:40 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unable to totally get rid of CONFIG_INPUT options with 2.6.6
In-Reply-To: <40C759ED.60705@nortelnetworks.com>
References: <40C759ED.60705@nortelnetworks.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen writes:
 > 
 > 
 > I have a machine whose only contacts with the outside world are ethernet and 
 > serial.  For some reason, it appears to be impossible to disable CONFIG_INPUT. 
 > Is this by design?  I have everything removed from the input config screen, but 
 > after some digging it appears that CONFIG_INPUT is not actually controlled by 
 > any config files.

Enable CONFIG_EMBEDDED, then you'll be able to get rid of INPUT_MOUSEDEV etc.
