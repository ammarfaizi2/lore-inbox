Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbTA0QZp>; Mon, 27 Jan 2003 11:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTA0QZp>; Mon, 27 Jan 2003 11:25:45 -0500
Received: from [81.2.122.30] ([81.2.122.30]:50948 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267218AbTA0QZm>;
	Mon, 27 Jan 2003 11:25:42 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301271635.h0RGZZhY000477@darkstar.example.net>
Subject: Set3 scancodes for Japanese keyboard
To: linux-kernel@vger.kernel.org
Date: Mon, 27 Jan 2003 16:35:35 +0000 (GMT)
In-Reply-To: <20030125184046.A16824@ucw.cz> from "Vojtech Pavlik" at Jan 25, 2003 06:40:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > What kernel this is tested with? What method used? These don't look like
> > > Set2 codes AT ALL.
> > 
> > The kernel is 2.4.20.  The keycode is the output from showkey, and the
> > make and break codes are the output from showkey -s.
> > 
> > Should I have used I8042_DEBUG_IO instead?  :-/
> 
> With 2.5, yes, that'd be much better. And yet better it'd be if you'd
> have used the "i8042_direct=1" kernel option, and for set3 the
> "atkbd_set=3" option.
> 
> I'm sorry to tell you after you wrote it all down, but these are set1
> scancodes you see.

Here are the set 3 scancodes for my Japanese keyboard.

If the set 2 codes are still of interest, I can do those as well, but
set 3 seems to be a much more useful mode, because there is a direct
mapping of keys to scancodes, instead of the more complicated
similated shift key codes that set 2 produces.

ESC                             08 F0 08
F1                              07 F0 07
F2                              0F F0 0F
F3                              17 F0 17
F4                              1F F0 1F
F5                              27 F0 27
F6                              2F F0 2F
F7                              37 F0 37
F8                              3F F0 3F
F9                              47 F0 47
F10                             4F F0 4F
F11                             56 F0 56
F12                             5E F0 5E

HANKAKU/ZENKAKU                 0E F0 0E
1                               16 F0 16
2                               1E F0 1E
3                               26 F0 26
4                               25 F0 25
5                               2E F0 2E
6                               36 F0 36
7                               3D F0 3D
8                               3E F0 3E
9                               46 F0 46
0                               45 F0 45
-                               4E F0 4E
^                               55 F0 55
YEN                             13 F0 13
BACKSPACE                       66 F0 66

TAB                             0D F0 0D
Q                               15 F0 15
W                               1D F0 1D
E                               24 F0 24
R                               2D F0 2D
T                               2C F0 2C
Y                               35 F0 35
U                               3C F0 3C
I                               43 F0 43
O                               44 F0 44
P                               4D F0 4D
@                               54 F0 54
[                               5B F0 5B

A                               1C F0 1C
S                               1B F0 1B
D                               23 F0 23
F                               2B F0 2B
G                               34 F0 34
H                               33 F0 33
J                               3B F0 3B
K                               42 F0 42
L                               4B F0 4B
;                               4C F0 4C
:                               52 F0 52
]                               53 F0 53
ENTER                           5A F0 5A

LEFT SHIFT                      12 F0 12
Z                               1A F0 1A
X                               22 F0 22
C                               21 F0 21
V                               2A F0 2A
B                               32 F0 32
N                               31 F0 31
M                               3A F0 3A
,                               41 F0 41
.                               49 F0 49
/                               4A F0 4A
\                               5C F0 5C
RIGHT SHIFT                     59 F0 59

LEFT CONTROL                    11 F0 11
KANJI/KANAKANA                  19 F0 19
MUHENKAN                        85 F0 85
SPACE                           29 F0 29
ZENKOHO/HENKAN (JIKOHO)/ZENKOHO 86 F0 86
HIRAGANA                        87 F0 87
ZENMEN KI                       39 F0 39
RIGHT CONTROL                   58 F0 58

PAGE/SYSRQ                      57 F0 57
SCROLL LOCK
5F <-
ED ->
FA <-
00 ->
FA <-
F0 <-
5F <-
SHIFT-SCROLL LOCK (NUMLOCK)     5F F0 5F
PAUSE/BREAK                     62 F0 62

INSERT                          67 F0 67
HOME                            6E F0 6E
PAGE UP                         6F F0 6F
DELETE                          64 F0 64
END                             65 F0 65
PAGE DOWN                       6D F0 6D

CURSOR UP                       63 F0 63
CURSOR DOWN                     60 F0 60
CURSOR LEFT                     61 F0 61
CURSOR RIGHT                    69 F0 69

KEYPAD *                        7E F0 7E
KEYPAD /                        77 F0 77
KEYPAD ,
76 <-
ED ->
FA <-
00 ->
FA <-
F0 <-
76 <-
KEYPAD -                        84 F0 84
KEYPAD +                        7C F0 7C
KEYPAD ENTER                    79 F0 79
KEYPAD .                        71 F0 71
KEYPAD 0                        70 F0 70
KEYPAD 1                        69 F0 69
KEYPAD 2                        72 F0 72
KEYPAD 3                        7A F0 7A
KEYPAD 4                        6B F0 6B
KEYPAD 5                        73 F0 73
KEYPAD 6                        74 F0 74
KEYPAD 7                        6C F0 6C
KEYPAD 8                        75 F0 75
KEYPAD 9                        7D F0 7D

John.
