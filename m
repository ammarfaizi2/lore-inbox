Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264979AbUFALVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbUFALVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbUFALVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:21:42 -0400
Received: from styx.suse.cz ([82.208.2.94]:14465 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264979AbUFALVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:21:00 -0400
Date: Tue, 1 Jun 2004 13:22:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040601112202.GA1908@ucw.cz>
References: <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org> <20040530114332.GA1441@ucw.cz> <MPG.1b23f41bee99410e9896a8@news.gmane.org> <20040530125918.GA1611@ucw.cz> <MPG.1b2424ed871e68c89896aa@news.gmane.org> <20040530203146.GA1941@ucw.cz> <MPG.1b2467af841573119896ae@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b2467af841573119896ae@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 10:51:18PM +0200, Giuseppe Bilotta wrote:

> > > > I'm not very familiar with xkb configuration. Perhaps you'd be willing
> > > > to write that definition file? I'll certainly help you from the kernel
> > > > side - I can even generate a list of keycode - scancode - meaning
> > > > relations for you.
> > > 
> > > If you do generate a list of keycode - scancode - meaning pairs 
> > > it will surely make my life easier.
> > > 
> > > I'm not particularly familiar with xkb configuration either. I 
> > > can *probably* make it work (i.e. test it as functional) on my 
> > > Dell Inspiron 8200 keyboard and on a standard pc104 keyboard 
> > > only. You probably need somebody else to work out the details 
> > > for other keyboards, though.
> > 
> > Ok, I'll try to produce something.
> 
> Thanks.

Here we go. This is a list of scancodes that the kernel produces in RAW
emulation mode, independent of the keyboard type.
  
Key  Key                    Press                Release
Code Name                   ScanCode(s)          ScanCode(s)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1: KEY_ESC                01		--->	 81
  2: KEY_1                  02		--->	 82
  3: KEY_2                  03		--->	 83
  4: KEY_3                  04		--->	 84
  5: KEY_4                  05		--->	 85
  6: KEY_5                  06		--->	 86
  7: KEY_6                  07		--->	 87
  8: KEY_7                  08		--->	 88
  9: KEY_8                  09		--->	 89
 10: KEY_9                  0a		--->	 8a
 11: KEY_0                  0b		--->	 8b
 12: KEY_MINUS              0c		--->	 8c
 13: KEY_EQUAL              0d		--->	 8d
 14: KEY_BACKSPACE          0e		--->	 8e
 15: KEY_TAB                0f		--->	 8f
 16: KEY_Q                  10		--->	 90
 17: KEY_W                  11		--->	 91
 18: KEY_E                  12		--->	 92
 19: KEY_R                  13		--->	 93
 20: KEY_T                  14		--->	 94
 21: KEY_Y                  15		--->	 95
 22: KEY_U                  16		--->	 96
 23: KEY_I                  17		--->	 97
 24: KEY_O                  18		--->	 98
 25: KEY_P                  19		--->	 99
 26: KEY_LEFTBRACE          1a		--->	 9a
 27: KEY_RIGHTBRACE         1b		--->	 9b
 28: KEY_ENTER              1c		--->	 9c
 29: KEY_LEFTCTRL           1d		--->	 9d
 30: KEY_A                  1e		--->	 9e
 31: KEY_S                  1f		--->	 9f
 32: KEY_D                  20		--->	 a0
 33: KEY_F                  21		--->	 a1
 34: KEY_G                  22		--->	 a2
 35: KEY_H                  23		--->	 a3
 36: KEY_J                  24		--->	 a4
 37: KEY_K                  25		--->	 a5
 38: KEY_L                  26		--->	 a6
 39: KEY_SEMICOLON          27		--->	 a7
 40: KEY_APOSTROPHE         28		--->	 a8
 41: KEY_GRAVE              29		--->	 a9
 42: KEY_LEFTSHIFT          2a		--->	 aa
 43: KEY_BACKSLASH          2b		--->	 ab
 44: KEY_Z                  2c		--->	 ac
 45: KEY_X                  2d		--->	 ad
 46: KEY_C                  2e		--->	 ae
 47: KEY_V                  2f		--->	 af
 48: KEY_B                  30		--->	 b0
 49: KEY_N                  31		--->	 b1
 50: KEY_M                  32		--->	 b2
 51: KEY_COMMA              33		--->	 b3
 52: KEY_DOT                34		--->	 b4
 53: KEY_SLASH              35		--->	 b5
 54: KEY_RIGHTSHIFT         36		--->	 b6
 55: KEY_KPASTERISK         37		--->	 b7
 56: KEY_LEFTALT            38		--->	 b8
 57: KEY_SPACE              39		--->	 b9
 58: KEY_CAPSLOCK           3a		--->	 ba
 59: KEY_F1                 3b		--->	 bb
 60: KEY_F2                 3c		--->	 bc
 61: KEY_F3                 3d		--->	 bd
 62: KEY_F4                 3e		--->	 be
 63: KEY_F5                 3f		--->	 bf
 64: KEY_F6                 40		--->	 c0
 65: KEY_F7                 41		--->	 c1
 66: KEY_F8                 42		--->	 c2
 67: KEY_F9                 43		--->	 c3
 68: KEY_F10                44		--->	 c4
 69: KEY_NUMLOCK            45		--->	 c5
 70: KEY_SCROLLLOCK         46		--->	 c6
 71: KEY_KP7                47		--->	 c7
 72: KEY_KP8                48		--->	 c8
 73: KEY_KP9                49		--->	 c9
 74: KEY_KPMINUS            4a		--->	 ca
 75: KEY_KP4                4b		--->	 cb
 76: KEY_KP5                4c		--->	 cc
 77: KEY_KP6                4d		--->	 cd
 78: KEY_KPPLUS             4e		--->	 ce
 79: KEY_KP1                4f		--->	 cf
 80: KEY_KP2                50		--->	 d0
 81: KEY_KP3                51		--->	 d1
 82: KEY_KP0                52		--->	 d2
 83: KEY_KPDOT              53		--->	 d3
 85: KEY_ZENKAKUHANKAKU     76		--->	 f6
 86: KEY_102ND              56		--->	 d6
 87: KEY_F11                57		--->	 d7
 88: KEY_F12                58		--->	 d8
 89: KEY_RO                 73		--->	 f3
 90: KEY_KATAKANA           78		--->	 f8
 91: KEY_HIRAGANA           77		--->	 f7
 92: KEY_HENKAN             79		--->	 f9
 93: KEY_KATAKANAHIRAGANA   70		--->	 f0
 94: KEY_MUHENKAN           7b		--->	 fb
 95: KEY_KPJPCOMMA          5c		--->	 dc
 96: KEY_KPENTER            e0 1c	--->	 e0 9c
 97: KEY_RIGHTCTRL          e0 1d	--->	 e0 9d
 98: KEY_KPSLASH            e0 35	--->	 e0 b5
 99: KEY_SYSRQ              e0 2a e0 37	--->	 e0 aa e0 b7
100: KEY_RIGHTALT           e0 38	--->	 e0 b8
101: KEY_LINEFEED           5b		--->	 db
102: KEY_HOME               e0 47	--->	 e0 c7
103: KEY_UP                 e0 48	--->	 e0 c8
104: KEY_PAGEUP             e0 49	--->	 e0 c9
105: KEY_LEFT               e0 4b	--->	 e0 cb
106: KEY_RIGHT              e0 4d	--->	 e0 cd
107: KEY_END                e0 4f	--->	 e0 cf
108: KEY_DOWN               e0 50	--->	 e0 d0
109: KEY_PAGEDOWN           e0 51	--->	 e0 d1
110: KEY_INSERT             e0 52	--->	 e0 d2
111: KEY_DELETE             e0 53	--->	 e0 d3
112: KEY_MACRO              e0 6f	--->	 e0 ef
113: KEY_MUTE               e0 20	--->	 e0 a0
114: KEY_VOLUMEDOWN         e0 2e	--->	 e0 ae
115: KEY_VOLUMEUP           e0 30	--->	 e0 b0
116: KEY_POWER              e0 5e	--->	 e0 de
117: KEY_KPEQUAL            59		--->	 d9
118: KEY_KPPLUSMINUS        e0 4e	--->	 e0 ce
119: KEY_PAUSE              e1 1d 45	--->	 e1 9d c5
121: KEY_KPCOMMA            7e		--->	 fe
122: KEY_HANGUEL            f1		--->	
123: KEY_HANJA              f2		--->	
124: KEY_YEN                7d		--->	 fd
125: KEY_LEFTMETA           e0 5b	--->	 e0 db
126: KEY_RIGHTMETA          e0 5c	--->	 e0 dc
127: KEY_COMPOSE            e0 5d	--->	 e0 dd
128: KEY_STOP               e0 68	--->	 e0 e8
129: KEY_AGAIN              e0 05	--->	 e0 85
130: KEY_PROPS              e0 06	--->	 e0 86
131: KEY_UNDO               e0 07	--->	 e0 87
132: KEY_FRONT              e0 0c	--->	 e0 8c
133: KEY_COPY               e0 78	--->	 e0 f8
134: KEY_OPEN               64		--->	 e4
135: KEY_PASTE              65		--->	 e5
136: KEY_FIND               e0 41	--->	 e0 c1
137: KEY_CUT                e0 3c	--->	 e0 bc
138: KEY_HELP               e0 75	--->	 e0 f5
139: KEY_MENU               e0 1e	--->	 e0 9e
140: KEY_CALC               e0 21	--->	 e0 a1
141: KEY_SETUP              66		--->	 e6
142: KEY_SLEEP              e0 5f	--->	 e0 df
143: KEY_WAKEUP             e0 63	--->	 e0 e3
144: KEY_FILE               67		--->	 e7
145: KEY_SENDFILE           68		--->	 e8
146: KEY_DELETEFILE         69		--->	 e9
147: KEY_XFER               e0 13	--->	 e0 93
148: KEY_PROG1              e0 1f	--->	 e0 9f
149: KEY_PROG2              e0 17	--->	 e0 97
150: KEY_WWW                e0 32	--->	 e0 b2
151: KEY_MSDOS              6a		--->	 ea
152: KEY_COFFEE             e0 12	--->	 e0 92
153: KEY_DIRECTION          6b		--->	 eb
154: KEY_CYCLEWINDOWS       e0 26	--->	 e0 a6
155: KEY_MAIL               e0 6c	--->	 e0 ec
156: KEY_BOOKMARKS          e0 66	--->	 e0 e6
157: KEY_COMPUTER           e0 6b	--->	 e0 eb
158: KEY_BACK               e0 6a	--->	 e0 ea
159: KEY_FORWARD            e0 69	--->	 e0 e9
160: KEY_CLOSECD            e0 23	--->	 e0 a3
161: KEY_EJECTCD            6c		--->	 ec
162: KEY_EJECTCLOSECD       e0 7d	--->	 e0 fd
163: KEY_NEXTSONG           e0 19	--->	 e0 99
164: KEY_PLAYPAUSE          e0 22	--->	 e0 a2
165: KEY_PREVIOUSSONG       e0 10	--->	 e0 90
166: KEY_STOPCD             e0 24	--->	 e0 a4
167: KEY_RECORD             e0 31	--->	 e0 b1
168: KEY_REWIND             e0 18	--->	 e0 98
169: KEY_PHONE              63		--->	 e3
170: KEY_ISO                70		--->	 f0
171: KEY_CONFIG             e0 01	--->	 e0 81
172: KEY_HOMEPAGE           e0 02	--->	 e0 82
173: KEY_REFRESH            e0 67	--->	 e0 e7
174: KEY_EXIT               71		--->	 f1
175: KEY_MOVE               72		--->	 f2
176: KEY_EDIT               e0 08	--->	 e0 88
177: KEY_SCROLLUP           75		--->	 f5
178: KEY_SCROLLDOWN         e0 0f	--->	 e0 8f
179: KEY_KPLEFTPAREN        e0 76	--->	 e0 f6
180: KEY_KPRIGHTPAREN       e0 7b	--->	 e0 fb
183: KEY_F13                5d		--->	 dd
184: KEY_F14                5e		--->	 de
185: KEY_F15                5f		--->	 df
186: KEY_F16                55		--->	 d5
187: KEY_F17                e0 03	--->	 e0 83
188: KEY_F18                e0 77	--->	 e0 f7
189: KEY_F19                e0 04	--->	 e0 84
190: KEY_F20                5a		--->	 da
191: KEY_F21                74		--->	 f4
192: KEY_F22                e0 79	--->	 e0 f9
193: KEY_F23                6d		--->	 ed
194: KEY_F24                6f		--->	 ef
200: KEY_PLAYCD             e0 28	--->	 e0 a8
201: KEY_PAUSECD            e0 29	--->	 e0 a9
202: KEY_PROG3              e0 2b	--->	 e0 ab
203: KEY_PROG4              e0 2c	--->	 e0 ac
205: KEY_SUSPEND            e0 25	--->	 e0 a5
206: KEY_CLOSE              e0 2f	--->	 e0 af
207: KEY_PLAY               e0 33	--->	 e0 b3
208: KEY_FASTFORWARD        e0 34	--->	 e0 b4
209: KEY_BASSBOOST          e0 36	--->	 e0 b6
210: KEY_PRINT              e0 39	--->	 e0 b9
211: KEY_HP                 e0 3a	--->	 e0 ba
212: KEY_CAMERA             e0 3b	--->	 e0 bb
213: KEY_SOUND              e0 3d	--->	 e0 bd
214: KEY_QUESTION           e0 3e	--->	 e0 be
215: KEY_EMAIL              e0 3f	--->	 e0 bf
216: KEY_CHAT               e0 40	--->	 e0 c0
217: KEY_SEARCH             e0 65	--->	 e0 e5
218: KEY_CONNECT            e0 42	--->	 e0 c2
219: KEY_FINANCE            e0 43	--->	 e0 c3
220: KEY_SPORT              e0 44	--->	 e0 c4
221: KEY_SHOP               e0 45	--->	 e0 c5
222: KEY_ALTERASE           e0 14	--->	 e0 94
223: KEY_CANCEL             e0 4a	--->	 e0 ca
224: KEY_BRIGHTNESSDOWN     e0 4c	--->	 e0 cc
225: KEY_BRIGHTNESSUP       e0 54	--->	 e0 d4
226: KEY_MEDIA              e0 6d	--->	 e0 ed

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
