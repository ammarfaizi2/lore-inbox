Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289556AbSAVXae>; Tue, 22 Jan 2002 18:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289555AbSAVXaZ>; Tue, 22 Jan 2002 18:30:25 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:21265
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S289551AbSAVXaG>; Tue, 22 Jan 2002 18:30:06 -0500
Subject: Re: Possible Idea with filesystem buffering.
From: Shawn Starr <spstarr@sh0n.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201222008280.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201222008280.32617-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 22 Jan 2002 18:31:26 -0500
Message-Id: <1011742313.269.15.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only functionality added to the kernel would be a a interface for
filesystems to share it would basically create kpagebuf_* functions.

Shawn.


On Tue, 2002-01-22 at 17:08, Rik van Riel wrote:
> On 22 Jan 2002, Shawn Starr wrote:
> 
> > the pagebuf daemon would use try_to_free_pages() periodically in its
> > queue.
> 
> So it wouldn't add any functionality to the kernel ?
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> 


