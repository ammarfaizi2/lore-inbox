Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTIBEPy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 00:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTIBEPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 00:15:54 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:43784 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263449AbTIBEPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 00:15:52 -0400
Date: Tue, 2 Sep 2003 06:15:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make clean misses stuff in 2.6.0-test4.
Message-ID: <20030902041547.GB1016@mars.ravnborg.org>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200309011742.37021.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309011742.37021.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 05:42:37PM -0400, Rob Landley wrote:
> I did a build as root, did a make clean (still as root), and then kicked off a
> build as my normal user account:
> 
> It died:
> 
> rm: cannot remove `.tmp_versions/cryptoloop.mod': Permission denied

The directory .tmp_versions is not deleted by 'make clean'.
For that you need 'make mrproper'.

	Sam
