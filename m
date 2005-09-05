Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVIEI4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVIEI4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVIEI4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:56:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28099 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932375AbVIEI4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:56:07 -0400
Date: Mon, 5 Sep 2005 01:54:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Teigland <teigland@redhat.com>
Cc: Joel.Becker@oracle.com, ak@suse.de, linux-cluster@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050905015408.21455e56.akpm@osdl.org>
In-Reply-To: <20050905043033.GB11337@redhat.com>
References: <20050901104620.GA22482@redhat.com>
	<20050903183241.1acca6c9.akpm@osdl.org>
	<20050904030640.GL8684@ca-server1.us.oracle.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<20050904045821.GT8684@ca-server1.us.oracle.com>
	<20050903224140.0442fac4.akpm@osdl.org>
	<20050905043033.GB11337@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland <teigland@redhat.com> wrote:
>
>  We export our full dlm API through read/write/poll on a misc device.
>

inotify did that for a while, but we ended up going with a straight syscall
interface.

How fat is the dlm interface?   ie: how many syscalls would it take?

