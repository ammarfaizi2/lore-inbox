Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTAYRLL>; Sat, 25 Jan 2003 12:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTAYRLL>; Sat, 25 Jan 2003 12:11:11 -0500
Received: from [81.2.122.30] ([81.2.122.30]:44037 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261364AbTAYRLI>;
	Sat, 25 Jan 2003 12:11:08 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301251720.h0PHKnL5000974@darkstar.example.net>
Subject: Set2 scancodes for Japanese keyboard
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sat, 25 Jan 2003 17:20:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030125141501.A5266@ucw.cz> from "Vojtech Pavlik" at Jan 25, 2003 02:15:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > If you can provide the complete key -> scancode table for that keyboard,
> > > or at least differences against standard US keyboard for both set 2 and
> > > set 3, that'd be great.

Here are the set 2 ones, I've missed out most of the letter and number
keys, because they all followed the obvious numerical sequence.  I'll
send the set 3 ones separately, (when I've typed them in :-) ).

Key
Keycode
Make scancode
Break scancode

Escape
1
0x01
0x81

F1
59
0x3b
0xbb

F10
68
0x44
0xc4

F11
87
0x57
0xd7

F12
88
0x58
0xd8

Printscreen?, (marked 'page', and something I can't read).
99
0xe0 0x2a 0xe0 0x37
0xe0 0xb7 0xe0 0xaa

Sys Rq, (alt and key above)
84
0x54
0xd4

Scroll lock
70
0x46
0xc6

Numlock, (shift scroll lock)
69
0x45
0xc5

Pause
119
0xe1 0x1d 0x45
0xe1 0x9d 0xc5

Break
101
0xe0 0x46
0xe0 0xc6

Hankaku/Zenkaku
None
0xff
none

1
2
0x02
0x83

0
11
0x0b
0x8b

-
12
0x0c
0x8c

shift -
13
0xb6 0x0d
0x8d 0x36

^
42,7
0x2a 0x07
0x8  0xaa

shift ^
none
0xff
none

yen
none
0xff
none

shift yen ( | )
43
0x2b
0xab

backspace
14
0x0e
0x8e

tab
15
0x0f
0x8f

q
16
0x10
0x90

p
25
0x19
0x99

@
42,3
0x2a 0x03
0x83 0xaa

shift @
release 54, 41, release 41, 54
0xb6 0x29
0xa9 0x36

[
26
0x1a
0x9a

enter
28
0x1c
0x9c

caps lock
58
0x3a
0xba

a
30
0x1e
0xae

l
38
0x26
0xa6

;
39
0x27
0xa7

shift ; ( + )
13
0x0d
0x8d

:
42 39
0x2a 0x27
0xa7 0xaa

shift : ( * )
9
0x09
0x89

]
27
0x1b
0x9b

left shift 42
0x2a
0xaa

z
44
0x2c
0xad

m
50
0x32
0xb2

,
51
0x33
0xb3

