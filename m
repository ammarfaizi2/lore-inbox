Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbUBXTwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbUBXTwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:52:21 -0500
Received: from tantale.fifi.org ([216.27.190.146]:21899 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262419AbUBXTwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:52:19 -0500
To: Jan Kara <jack@suse.cz>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Quota compilation fix
References: <87isi133wq.fsf@ceramic.fifi.org>
	<20040224122628.GA2780@atrey.karlin.mff.cuni.cz>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 24 Feb 2004 11:52:12 -0800
In-Reply-To: <20040224122628.GA2780@atrey.karlin.mff.cuni.cz>
Message-ID: <871xokdzmb.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> > Enclosed patch allows kernel compilation when CONFIG_QFMT_V2=y.
>   It looks like you have wrongly patched kernel - I don't see the
> DQUOT_SYNC() call in my 2.4.25 tree...

You're right, my bad. I have it because of another patch (namely the
LVM vfs-lock patch).

Marcelo, please discard this patch.

Phil.
