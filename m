Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSG2MN6>; Mon, 29 Jul 2002 08:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSG2MN6>; Mon, 29 Jul 2002 08:13:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53765 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315925AbSG2MN6>; Mon, 29 Jul 2002 08:13:58 -0400
Date: Mon, 29 Jul 2002 13:17:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: RFC: /proc/pci removal?
Message-ID: <20020729131717.A25451@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I seem to vaguely remember that a while ago (2.3 days?) there was
discussion about removing /proc/pci in favour of the lspci output,
however there doesn't seem much in google groups about it (and marc
seems useless with non-alphanumeric searches.)

Can anyone remember the consensus?  I seem to remember it wasn't
removed for 2.4 because certain distros rely on /proc/pci rather
than using pciutils.

I'm asking this question for purely self-centered reasons; I'd
personally rather get bug reports with the output of lspci -vv
and lspci -vvb rather than /proc/pci.  On machines where bus
addresses != kernel cookies, lspci is more than invaluable.

(Ok, so we could "fix" the bug reporters to stop whinging about
having to "port" lspci to their hardware, but that is a larger,
harder problem to solve.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

