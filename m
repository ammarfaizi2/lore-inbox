Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266436AbUG0RJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUG0RJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUG0RJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:09:25 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:7698 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266436AbUG0RJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:09:23 -0400
Date: Tue, 27 Jul 2004 19:10:25 +0200
From: DervishD <raul@pleyades.net>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: The dreadful CLOSE_WAIT
Message-ID: <20040727171025.GA26146@DervishD>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040727083947.GB31766@DervishD> <20040727160057.GE2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040727160057.GE2334@holomorphy.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi William :)

 * William Lee Irwin III <wli@holomorphy.com> dixit:
> >     Seems under Linux that, when a connection is in the CLOSE_WAIT
> > state, the only wait to go to LAST_ACK is the application doing the
> > 'shutdown()' or 'close()'. Doesn't seem to be a timeout for that.
> Probably best to implement timeouts by hand in your network daemon.

    Of course, this is a bug in the application, but anyway the
kernel (IMHO) shouldn't allow this.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
