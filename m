Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWA3AAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWA3AAi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 19:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWA3AAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 19:00:38 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:14881 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932093AbWA3AAh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 19:00:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UaZpIpmAEIQYIQ5BBahJs6G2FLFlyOWCJhhZZCW86xufprDuSOOD9mnJuySYnWnmK3Db19jkQbMbP8HctZ8xjv3op66bO9uigTsO3lw8/LzarGlFS4KAmVr5AJlqXT/ogQNkzXYR/XN87ORbZfq3Q6Au5J5DUaT9+kIsZkVD71c=
Message-ID: <7e90c9180601291600w53186f19w767ddcaa46a61039@mail.gmail.com>
Date: Sun, 29 Jan 2006 16:00:35 -0800
From: Peter Gordon <codergeek42@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: security capabilities on filesystems
Cc: Lukasz Stelmach <stlman@poczta.fm>
In-Reply-To: <43DD1FB7.9050509@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43DD1FB7.9050509@poczta.fm>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/06, Lukasz Stelmach <stlman@poczta.fm> wrote:
> Greetings.
>
> I've poke around for some information but all I got (was this lousy t-shirt)
> that there is no support for capablities stored on a filesystem. However, I'd
> like to ask if there are any chances to see this feature soon.
>

What do you mean exactly? Ext2 (and its journalled cousin, Ext3; I'm
not certain of other filesystems) can both store POSIX-style Access
Control Lists (ACLs) and SELinux labeling as part of the inode
metadata. Hope this helps.
