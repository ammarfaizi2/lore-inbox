Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVLIOOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVLIOOJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVLIOOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:14:09 -0500
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:45705 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S932080AbVLIOOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:14:08 -0500
Date: Fri, 9 Dec 2005 16:14:01 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH 1/1 2.6.15-rc4-git1] Fix switching to KD_TEXT
Message-ID: <20051209141401.GA2724@sci.fi>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	"Antonino A. Daplas" <adaplas@gmail.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <4398B888.50005@t-online.de> <4398CEAF.9050303@gmail.com> <43997037.4020206@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43997037.4020206@t-online.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 12:53:27PM +0100, Knut Petersen wrote:
> And please don´t argue that X or certain releases are broken. That is 
> true, but ordinary
> users will use those broken versions for years.

Then they should just keep using vgacon.

However if you're really going to add more uneccessary set_par() calls 
please make them configurable (eg. CONFIG_BROKEN_X). I'll go crazy if my 
CRT is going to start resyncing on every vt switch.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
