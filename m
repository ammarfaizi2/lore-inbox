Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289679AbSAWFZ1>; Wed, 23 Jan 2002 00:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289699AbSAWFZR>; Wed, 23 Jan 2002 00:25:17 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:44306
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S289697AbSAWFZH>; Wed, 23 Jan 2002 00:25:07 -0500
Subject: Re: Possible Idea with filesystem buffering.
From: Shawn Starr <spstarr@sh0n.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0201222136510.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201222136510.32617-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 23 Jan 2002 00:26:33 -0500
Message-Id: <1011763595.5117.5.camel@coredump>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VM is busy with other tasks so why not have a daemon handle pages
delegated from the VM? Having a pagebuf daemon would allow for delay
writes and allow for perhaps readahead buffering of data having theses
would take some pressure off of the VM no?


On Tue, 2002-01-22 at 18:37, Rik van Riel wrote:
> On 22 Jan 2002, Shawn Starr wrote:
> 
> > The only functionality added to the kernel would be a a interface for
> > filesystems to share it would basically create kpagebuf_* functions.
> 
> What would these things achieve ?
> 
> It would be nice if you could give us a quick explanation of
> what exactly kpagebufd is supposed to do, if only so I can
> keep that in mind while working on the VM ;)
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


