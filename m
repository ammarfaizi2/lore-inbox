Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265931AbUFOUiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUFOUiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUFOUiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:38:07 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:48973 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265931AbUFOUg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:36:58 -0400
Date: Tue, 15 Jun 2004 22:46:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cross dependency of make menuconfig entried
Message-ID: <20040615204613.GJ2310@mars.ravnborg.org>
Mail-Followup-To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>,
	linux-kernel@vger.kernel.org
References: <20040615135224.A6090@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615135224.A6090@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 01:52:24PM +0000, Karel Kulhavý wrote:
> Hello
> 
> I have discovered that make menuconfig entries are inclusively cross-dependent.
> It means that if I disable and re-enable something that masks more entries,
> the entries are reset into their default state.
> 
> Toggling one checkbox can apparently cause toggling of another checkbox of the
> another checkbox is masked by the first checkbox.
> 
> I would like to know if toggling one checkbox can cause toggling another
> checkbox even in the case the second checkbox is not masked by the first one.

Could not reproduce this with 2.6 kernel.
If this is with the 2.4 kernel it will not be fixed.

	Sam
