Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEMHG>; Fri, 5 Jan 2001 07:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEMG4>; Fri, 5 Jan 2001 07:06:56 -0500
Received: from zeus.kernel.org ([209.10.41.242]:23571 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129183AbRAEMGm>;
	Fri, 5 Jan 2001 07:06:42 -0500
Date: Fri, 5 Jan 2001 11:05:19 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Stefan Traby <stefan@hello-penguin.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010105110519.P1290@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com> <20010104220821.B775@stefan.sime.com> <20010104224946.C1290@redhat.com> <20010105020137.A1396@stefan.sime.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010105020137.A1396@stefan.sime.com>; from stefan@hello-penguin.com on Fri, Jan 05, 2001 at 02:01:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 05, 2001 at 02:01:37AM +0100, Stefan Traby wrote:
> 
> Please tell me how to specify "noreplay" for the initial "/" mount
> :)

You don't have to: the filesystem knows when a root mount is
happening, and can do the extra work then to make sure that the mount
isn't failed on a readonly media.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
