Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpOv8zlIERBB1QoCsDcBD7fUQng==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Tue, 06 Jan 2004 00:00:01 +0000
Message-ID: <041901c415a4$ebfcce50$d100000a@sbs2003.local>
Content-Class: urn:content-classes:message
Importance: normal
Subject: Re: 2.6.0: atyfb broken
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Reply-To: <benh@kernel.crashing.org>
To: <Administrator@osdl.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <claas@rootdir.de>,
        "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401052333390.7347-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0401052333390.7347-100000@phoenix.infradead.org>
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 16:45:55 +0100
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:45:55.0171 (UTC) FILETIME=[EC03D330:01C415A4]

On Tue, 2004-01-06 at 10:33, James Simmons wrote:
> > > Ben, if you could shoot me over a copy of the current linux-fbdev tree that
> > > might help things along a bit.
> > 
> > linux-fbdev is at bk://fbdev.bkbits.net/fbdev-2.5
> > 
> > Some things in there are too crappy though, like the whole gfx-client
> > stuff, I suggest you don't merge as-is. I will start sending you
> > patches tomorrow hopefully.
> 
> Is the gfx-client stuff the only issue for 

The main one. I have some problems with the pixmap code (see my other
message about this, the locking is definitely broken) and I'm not sure
we want to merge the allocation changes upstream yet (well, maybe they
are stable enough by now ?)

Ben.
 
